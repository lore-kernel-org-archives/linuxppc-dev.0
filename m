Date: Sun, 12 Jan 2003 18:14:51 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Status of linuxppc_2.5
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15900.45086.608629.636148@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E18XlhJ-0000D2-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   9 Jan, this message from Paul Mackerras echoed through cyberspace:
>> Tried to compile my standard kernel compile a while back, and found the
>> following things broken (didn't have time to try fixing yet...):
>>
>> - 53c94 Mac SCSI
>
> I just pushed a fix (untested) for mac53c94 scsi to linuxppc-2.5.
> If you try it out, let me know how it goes.

Thanks, at least it compiles :-) I'll have to see how I can test 2.5
kernels since most of my partitions are on LVM1 and that one has just
been removed in 2.5...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
