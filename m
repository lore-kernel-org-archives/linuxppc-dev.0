Date: Thu, 22 Jul 1999 11:54:54 -0500 (CDT)
From: "ian reinhart geiser (ADMIN)" <geiseri@msoe.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Unresolved symbols....
In-Reply-To: <m117LAK-0000WZC@tri-yann.crf.canon.fr>
Message-ID: <Pine.OSF.3.96.990722115246.30323A-100000@torres.msoe.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i am compileing the postgres ODBC drivers and i get the following
error on linking:

ld -Bdynamic -shared -soname libpsqlodbc.so.0.25 -Bsymbolic -lc -lm -o
libpsqlod
bc.so.0.25 info.o bind.o columninfo.o connection.o convert.o drvconn.o
environ.o
 execute.o lobj.o misc.o options.o pgtypes.o psqlodbc.o qresult.o
results.o sock
et.o parse.o statement.o gpps.o tuple.o tuplelist.o dlg_specific.o   -lc
/lib/libc.so.6: undefined reference to `_r_debug@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_unload_cache@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_init_next@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_signal_error@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_relocate_object@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_initial_searchlist@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_profile@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_global_scope_alloc@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_fpu_control@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_debug_message@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_mcount@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_debug_initialize@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_start_profile@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_check_all_versions@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_catch_error@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_map_object@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_loaded@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_main_searchlist@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_profile_map@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_profile_output@@GLIBC_2.1'
/lib/libc.so.6: undefined reference to `_dl_map_object_deps@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_debug_impcalls@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_debug_state@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `_dl_lookup_symbol@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `__libc_enable_secure@@GLIBC_2.0'
/lib/libc.so.6: undefined reference to `__libc_stack_end@@GLIBC_2.1'
make: *** [libpsqlodbc.so.0.25] Error 1

any ideas on a way to fix this bugger?

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
