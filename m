Date: Thu, 22 Jul 1999 12:23:45 -0500 (CDT)
From: "ian reinhart geiser (ADMIN)" <geiseri@msoe.edu>
To: Daniel Jacobowitz <drow@false.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Unresolved symbols....
In-Reply-To: <19990722131559.A4092@drow.res.cmu.edu>
Message-ID: <Pine.OSF.3.96.990722122139.30546A-100000@torres.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 22 Jul 1999, Daniel Jacobowitz wrote:

> 
> On Thu, Jul 22, 1999 at 11:54:54AM -0500, ian reinhart geiser (ADMIN) wrote:
> > 
> > i am compileing the postgres ODBC drivers and i get the following
> > error on linking:
> > 
> > ld -Bdynamic -shared -soname libpsqlodbc.so.0.25 -Bsymbolic -lc -lm -o
> > libpsqlod
> > bc.so.0.25 info.o bind.o columninfo.o connection.o convert.o drvconn.o
> > environ.o
> >  execute.o lobj.o misc.o options.o pgtypes.o psqlodbc.o qresult.o
> > results.o sock
> > et.o parse.o statement.o gpps.o tuple.o tuplelist.o dlg_specific.o   -lc
> 
> I'm not so sure that you want -Bsymbolic.  Plus, using ld for linking
> is rarely a good idea; you should always use gcc.
> 
> > /lib/libc.so.6: undefined reference to `_r_debug@@GLIBC_2.0'
> > /lib/libc.so.6: undefined reference to `_dl_unload_cache@@GLIBC_2.1'
> 
> All of these are symbols from the dynamic linker.  That they aren't
> being found implies mislinking.
> 
	
	this is from there stock configure script.
	all i did was commented out some loggin procedures
	in misc.c of the odbc intercace ( mulog and qlog).

	this allows the package to compile but not to link

	i even did a make clean and this still pops up.

	i have been messing with this now for a few weeks 
	but only now have i gotten ODBC to compile...

	-ian reinhart geiser

.-----------------------------------------------------------.
|[]                   NeXT Generation                    [X]|
|--------------------------,--------------------------------.
|  UNIX GEEK,              | Office:    I have none...      |
|  Macintosh Specialist @  | Phone:     414.277.7288        |
|  Milwaukee School of     |                                |
|        Engineering       |--------------------------------|
|                          |                                |
|   ian reinhart geiser    | phone:   414.220.9683          |
|   Apt #5                 | email:   geiseri@msoe.edu      |
|   828 N Milwaukee St     | web:     www.msoe.edu/~geiseri |
|   Milwaukee, WI 53202    |  NeXT/Be/Cyberdog Mail okay!   |
|                          |   MIME or BinHex preferred     |
|--------------------------'--------------------------------|
'-----------------------------------------------------------'


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
