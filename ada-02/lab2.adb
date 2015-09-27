------------------------------------
--      Parallel programming      --
--             Lab 2              --
--                                --
-- Func1: C = A - B * (MA * MD)   --
-- Func2: o = Min(MK * MM)        --
-- Func3: T = (MS * MZ) * (W + X) --
--                                --
-- @author Olexandr Kovalchuk     --
-- @group IP 32                   --
--                                --
-- @date 2015-09-27               --
------------------------------------
with Data; 
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Lab2 is
  SIZE: constant Integer := 1000;
  package DataBase is new Data(SIZE => SIZE); use DataBase;

  procedure RunTasks is
    task type GenericLabTask(cpuId, priority, storage, fnId: Integer) is
      pragma Storage_Size (storage);
      pragma Priority (priority);
    end GenericLabTask;

    task body GenericLabTask is
    begin
      Put_Line("Task " & Integer'Image(fnId) & " started");
      case fnId is
        when 1 =>
          declare
            MA, MD: Matrix;
            A, B, C: Vector;
          begin
            GetMatrix(MA);
            GetMatrix(MD);
            GetVector(A);
            GetVector(B);
            C := Func1(A, B, MA, MD);
            Put("C = A - B * (MA * MD) = ("); Put(C); Put_Line(")");
          end;
        when 2 =>
          declare
            MK, MM: Matrix;
            o: Integer;
          begin
            GetMatrix(MK);
            GetMatrix(MM);
            o := Func2(MK, MM);
            Put("o = Min(MK * MM) = "); Put(o, 2); New_Line;
          end;
        when 3 =>
          declare
            MS, MZ: Matrix;
            W, X, T: Vector;
          begin
            GetMatrix(MS);
            GetMatrix(MZ);
            GetVector(W);
            GetVector(X);
            T := Func3(MS, MZ, W, X);
            Put("T = (MS * MZ) * (W + X) = ("); Put(T); Put_Line(")");
          end;
        when others => null;
      end case;
      Put_Line("Task " & Integer'Image(fnId) & " finished");
    end GenericLabTask;

    T1: GenericLabTask(1, 5, 32*SIZE*(SIZE + 3), 1);
    T2: GenericLabTask(1, 5, 32*SIZE*SIZE, 2);
    T3: GenericLabTask(1, 5, 32*SIZE*(SIZE + 2), 3);
  begin
    null;
  end RunTasks;
begin
  Put_Line("Lab2 started");
  RunTasks;
  Put_Line("Lab2 finished");
end Lab2;

