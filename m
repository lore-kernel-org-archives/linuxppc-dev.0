Message-Id: <v03110702b399351bdfdd@[209.183.128.103]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 25 Jun 1999 09:35:48 -0400
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-dev@lists.linuxppc.org,
        "Conrad M. Hirano" <placebo2@pobox.com>
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Machine Check in Kernel Mode with Paul's 2.2.10 on B+W G3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Conrad,

>>  hda: hda timeout waiting for DMA

>>Machine check in kernel mode
>>Caused by (from msr): regs c01a4c18 Unknown values in msr

>>Here are some register values:
>>   NIP: C00BDE58  LR: C00BDE14  MSR: 00009030  Trap: 0200
>>Task= c01a2f58[0] 'swapper' mm->pgd
>>Last syscall: 112

>>Backtrace: C00BDE14 COO13C04 C001C850 C0003B68 C001F460 C00069F4 ...

>>There does not seem to be anything unusual until the DMA timeout message
>>waiting for hda.


>I've run into the same problem with my B&W G3.  The only workaround so
>far is it is to plug the hard drive into the other IDE channel on the
>motherboard.
>
>Earlier in the boot sequence, you'll see that hda comes up in DMA mode.
>After moving the cable to the other IDE channel, you'll see that hda then
>comes up in PIO mode, thus avoiding the later DMA timeout.
>
>Conrad Hirano

I know what DMA mode is and how it works, but I don't know what PIO mode
is?  What impact on MacOS performance will moving the cable have?  Isn't
DMA mode the fastest way to transfer blocks of data to and from memory?
Will PIO mode have much of a performance penalty (I have to use this
machine under MacOS as much or more than I do under LinuxPPC).

Thanks,

Kevin




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
