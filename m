Message-ID: <3F3BEE49.4050806@mvista.com>
Date: Thu, 14 Aug 2003 15:17:13 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hardware Requrements for Linux on 405GPr
References: <21518-79162@sneakemail.com>
In-Reply-To: <21518-79162@sneakemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


An RTC is not required for Linux.  Many designs I have seen do not have
one.  However, an RTC is an excellent device to have available!  Various
applications and services may require a consistant, ever increasing
time.  NFS is the one that comes to mind immediatly.  If the device is
rebooted and the time goes back to default, NFS may have problems.

RAM is something else thats nice to have.. :)  While 16 MB is usable, 32
MB or more is preferred in the applications that I am used to.  (You can
get away with 8 MB, but thats very tight usually.)

--Mark

Stephen Williams wrote:
>
> We are in the process of designing a PCI board that will have
> a 405GPr, some SDRAM and a Compact Flash. (Not to mention
> the functionality of our device.) Outside the 405GPr itself,
> are there any minimum device requirements for a Linux that
> can for example run some simple servers?
>
> For example, the matter of whether or not a RTC is required
> came up amongst the designers.
> --
> Steve Williams                "The woods are lovely, dark and deep.
> steve at icarus.com           But I have promises to keep,
> http://www.icarus.com         and lines to code before I sleep,
> http://www.picturel.com       And lines to code before I sleep."
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
