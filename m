Message-Id: <199910111812.UAA00352@piglet.cpu.lu>
Date: Mon, 11 Oct 1999 20:12:06 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: busmaster/latency for video
To: Geert.Uytterhoeven@sonycom.com
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.10.9910110828450.9144-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  11 Oct, this message from Geert Uytterhoeven echoed through cyberspace:
> On Fri, 8 Oct 1999, Michel Lanners wrote:
>> OF itself doesn't enable any memory or IO region; it's the
>> device-specific init code (which might be on-board for PCI cards, or in
>> OF for motherboard devices).
>> 
>> There are, however, a few things OF does for _every_ PCI device, among
>> which enabling bus mastering and assigning memory and/or IO resources.
>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> assigning some memory and/or IO resources? Or is this only the case in the
> Longtrail-OF-which-is-better-than-Apple-OF-except-maybe-for-assigning-resources
> case?

Hm, my 7600's OF version 1.05 assigns memory and IO regions for two
boards that don't have any OF code: a Matrox Millenium I and a Promise
Ultra/66 IDE controller. Never had any problem in that area..

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
