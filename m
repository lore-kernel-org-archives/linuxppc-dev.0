To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BAT mapping exported to user-space
References: <EB9CAD60-DF2E-11D8-910D-003065F9B7DC@embeddededge.com>
From: Linh Dang <linh@linhdang.home>
Date: Mon, 26 Jul 2004 14:33:27 -0400
In-Reply-To: <EB9CAD60-DF2E-11D8-910D-003065F9B7DC@embeddededge.com> (Dan
 Malek's message of "Mon, 26 Jul 2004 14:09:22 -0400")
Message-ID: <wn5ekmysjns.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:

>
> On Jul 26, 2004, at 1:20 PM, Linh Dang wrote:
>
>> - has it been discussed/comptemplate/done before?
>
> Of course.  Use mmap(), either on /dev/mem directly, or more
> preferable through a simple device driver for your ASIC that
> could also do simple system protection.
>
> Please don't be making such memory mapping kernel
> modifications.  It will only cause future trouble.
>
> -- Dan


My understanding is:

- mmap(2) uses pages to map the device (my platform doesn't have large page.)
- mapping a large address range (hundreds-of-megabytes) is much more
  efficient with BATs than with pages.

So, do you mean:
        - mmap(2) can use BATs? or
        - the difference in performance is negligible between BATs and
          pages when mapping an address range of 200MBs?


Thanx
--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
