Message-Id: <200103062328.SAA01824@p2.parker.boston.ma.us>
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm/io.h; why does writel() write an le32 on ppc? 
In-reply-to: Your message of "Wed, 07 Mar 2001 00:23:13 +0100."
             <Pine.HPX.4.10.10103070022380.3942-100000@gra-ux1.iram.es>
Date: Tue, 06 Mar 2001 18:28:55 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>On Tue, 6 Mar 2001, Brad Parker wrote:
...
>> in asm/io.h it uses out_le32, unless the machine is an APUS, in which
>> case it just writes big endian...
>>
>> (is PCI defined as little endian?)
>
>Sadly, yes.

Ok, so the APUS pci bridge must be doing byte swapping.  I assume the
ppc macintosh pci bridges do not byte swap...

I see it now.  Thanks!

-brad


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
