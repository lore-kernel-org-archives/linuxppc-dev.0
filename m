Message-ID: <29263-26120@sneakemail.com>
Date: Thu, 04 Mar 2004 22:16:39 -0800
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How Can The Starting Address Of An Image In ELF File BeChanged
References: <OFD40F49BF.D7A17B63-ON65256E4E.00170A96@lntinfotech.com>
In-Reply-To: <OFD40F49BF.D7A17B63-ON65256E4E.00170A96@lntinfotech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thamarai Selvan Thamarai.Selvan-at-lntinfotech.com |PPC Linux Embedded|
wrote:
> Hi all,
>
> I created the elf file of the kernel using "make vmlinux", when i checked
> the created system.map i found the the kernel image starting from
> 0xc0000000. Can any tell where this address is defined or configured? and
> how can this be changed to 0x0000000 is it possible?

The linux cernel is linked to 0xc0000000, and the entry is really
up there. In fact, the kernel is loaded starting at 0x0, and there
is code at the beginning that turns on address translation so that
it appears at the right place.

In other words, there is nothing for you to change.


--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
