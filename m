Message-ID: <XFMail.990802052054.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <990801202455.ZM22552@redrock.lan>
Date: Mon, 02 Aug 1999 05:20:54 -0600 (MDT)
From: Gary Thomas <gdt@linuxppc.org>
To: Kevin Buettner <kev@primenet.com>
Subject: Re: gdb broken under linuxppc r5 tools
Cc: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "Kevin B. Hendricks" <kbhend@business.wm.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 01-Aug-99 Kevin Buettner wrote:
> 
> On Aug 1,  9:03pm, Franz Sirl wrote:
> 
>> Am Son, 01 Aug 1999 schrieb Kevin B. Hendricks:
>> >Hey,
>> >
>> >Does anyone know what's up with gdb lately?  It used to be quite stable but
>> >since I upgraded to the glibc, binutils, egcs, gdb from Linuxppc R5 cd, I
>> >can't seem to set any breakpoints in shared libraries (or they show up
>> >someplace else at random).  Functions are missing (or don't show up) and if
>> >I try to disassemble one function in a shared library, I often get another.
>> >
>> >I really need a working stable gdb.
>> >
>> >Has anyone else run into this.  If so, exactly what versions of gdb, glibc,
>> >binutils, egcs are stable together, especially when working with shared
>> >libraries?
>> 
>> Well, you've hit one of our weakest points here. AFAIK there's currently
>> nobody
>> taking care of gdb on Linux/PPC. In fact we are lucky that Kevin Buettner's
>> old
>> patch could be converted to 4.17.x. Unfortunately it's still not integrated
>> into gdb's mainline due to copyright issues, so we have to reintegrate the
>> patch
>> in every new version :-(.
>> 
>> So, is someone willing to take care of gdb on Linux/PPC?
> 
> Kevin, Franz, et.al,
> 
> Earlier this year, Metrowerks and I signed the copyright assignments
> required by the FSF.  Beginning August 9, I will be starting work at
> Cygnus as a GDB engineer.  One of the things that I'll work on is a
> merge of my patches into the current gdb mainline.  It'll be my goal
> to get a solid, usable gdb up and running on Linux/PPC again.
> 

Kevin B.,

Firstly, congratulations and welcome to the fold :-)

Secondly, while you're in there, can you look at my patches for GDB-4.18.
I've made a useable GDB for this version, with no input from any of the
4.17 patches BTW.  They might be easier to make into a "clean" set for
the latest version.  You can find my patches in the RPM I uploaded to
  ftp://ftp.linuxppc.org/users/gdt/redhat/SRPMS

When you get something ready, let me know and I'll help check it out.

Thanks.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
