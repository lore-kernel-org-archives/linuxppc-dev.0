Message-ID: <32336-60300@sneakemail.com>
Date: Thu, 14 Aug 2003 13:30:30 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hardware Requrements for Linux on 405GPr
References: <21518-79162@sneakemail.com> <3F3BEE49.4050806@mvista.com>
In-Reply-To: <3F3BEE49.4050806@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle fray-at-mvista.com |PPC Linux Embedded| wrote:
> An RTC is not required for Linux.  Many designs I have seen do not have
> one.  However, an RTC is an excellent device to have available!  Various
> applications and services may require a consistant, ever increasing
> time.  NFS is the one that comes to mind immediatly.  If the device is
> rebooted and the time goes back to default, NFS may have problems.

The first iteration of this device will HAVE a PCI connector and
go into a PCI slot of a host computer, but it will have a network
interface as well, to provide some minimal services such as a web
server for configuration and so forth. I can't thinkof anything
right off that will need the correct time, but who knows.

Well, actually there is logging.

As for memory, 64M of SDRAM w/ option for 128meg, and flash enough
to write a bootstrap loader to get the O/S off CompactFlash card.

--
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
