From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/ 
In-reply-to: Your message of "Thu, 29 Nov 2001 15:27:41 PDT."
             <20011129152741.L29541@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Nov 2001 09:38:36 +1100
Message-ID: <30984.1007073516@ocs3.intra.ocs.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 29 Nov 2001 15:27:41 -0700,
Tom Rini <trini@kernel.crashing.org> wrote:
>On Fri, Nov 30, 2001 at 09:19:20AM +1100, Keith Owens wrote:
>> The make rules I sent to Paul automatically generate platform.h and
>> platform_serial.h by copying the platform specific files to arch/ppc
>> under standard names.  If the platform has no *_serial.h file then
>> platform_serial.h is a zero length file.  So ppc code can always
>>
>> #include <platform.h>
>> #include <platform_serial.h>
>
>So <asm/serial.h> just has the above two lines

Yes.  We don't need no steenking #ifdefs.

>and all platforms need a
>platform/platform_serial.h file for serial to work with this scheme?

No, an empty one is automatically generated if necessary.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
