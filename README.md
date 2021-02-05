#### MODULE NAME
       DM (DM_synch, DM_asynch)

#### DEPENDENCIES
       None

#### INPUTS
Name | Size(Bits)
------|-------------
clk	| 1 (DM_synch only)
a   |     32     
wd  |     32     
we  |     1      

#### OUTPUTS
Name | Size(Bits)
------|-------------
rd  |     32     

#### DESCRIPTION
       Random  access  data  memory. rd = contents os address a.  Value at ad-
       dress a is set to wd if we is equal to 1.
       Synchronous and asynchronous components

#### AUTHOR
       Alexander T Pastoriza
       Trevor Cickovski

#### SEE ALSO
       qms(1), modclone(1)
