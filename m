Message-ID: <3B98F783.1266EC60@acm.org>
Date: Fri, 07 Sep 2001 09:36:19 -0700
From: Ira Weiny <iweiny@acm.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Cardbus issues on TiBook
References: <3B97DA58.6894B342@acm.org> <20010906211035.8782@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >So my question is, what does the above message mean?  It is something
> >which is worked around later, or could it be the root of my problem?
>
> Some more infos about the panic would be useful. Enable xmon and tell
> me what it sayd about the PC & LR of the crash, and the backtrace
> (obtained with the "t" command). If you use a recent yaboot and kernel,
> you may even add sysmap=<of_path_to_System.map> in yaboot.conf to get
> the System.map loaded along with the kernel. This will allow xmon to
> display function names as well as addresses in the backtrace.
>

I saved the following XMON dump...  (already had it enabled and it
dumped me there when the crash occured.)  I have translated it for you.
But I don't have the PC or LR.  I will have to recreate the failure
later tonight after I get off of work.

Also I used this line "sysmap=/boot/System.map-fw" to load the system
map but then I realized you said OpenFirmware path.  How do I calculate
the openfirmware path to the system map?  And would this be dynamic when
I recompile if I just put the file in the filesystem or would I have to
reload it with ybin?  Thanks again for all your help.

Here is the stack trace from "cat /proc/ioports":

vsnprintf
vsprintf
sprintf
do_resource_list
do_resource_list
get_resource_list
ioports_read_proc
proc_file_read
sys_read

Thanks again,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
