Return-Path: <justinmattock@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 3BEF0B70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 13:57:04 +1000 (EST)
Received: by pwi4 with SMTP id 4so84331pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 20:57:02 -0700 (PDT)
Message-ID: <4C997E94.8070407@gmail.com>
Date: Tue, 21 Sep 2010 20:57:08 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH 1/2 v3]Update broken web addresses.
References: <1285118957-24965-1-git-send-email-justinmattock@gmail.com>
	<alpine.LNX.2.00.1009221310500.4570@nippy.intranet>
In-Reply-To: <alpine.LNX.2.00.1009221310500.4570@nippy.intranet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, Randy Dunlap <rdunlap@xenotime.net>,
	linux-m32r@ml.linux-m32r.org, trivial@kernel.org,
	linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2010 08:25 PM, Finn Thain wrote:
>
> On Tue, 21 Sep 2010, Justin P. Mattock wrote:
>
>> Below is an update from the original, with changes to the broken web
>> addresses and removal of archive.org and moved to a seperate patch for
>> you guys to decide if you want to use this and/or just leave the old url
>> in and leave it at that..
>> Please dont apply this to anything just comments and fixes for now,
>
> You can use [RFC] in the Subject line instead of [PATCH] to indicate this.
>

alright..

>
>> diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
>> index 8f06408..234d9ee 100644
>> --- a/arch/m68k/mac/macboing.c
>> +++ b/arch/m68k/mac/macboing.c
>> @@ -114,7 +114,8 @@ static void mac_init_asc( void )
>>   			 *   16-bit I/O functionality.  The PowerBook 500 series computers
>>   			 *   support 16-bit stereo output, but only mono input."
>>   			 *
>> -			 *   http://til.info.apple.com/techinfo.nsf/artnum/n16405
>> +			 *   Article number 16405:
>> +			 *   http://support.apple.com/kb/TA32601
>>   			 *
>>   			 * --David Kilzer
>>   			 */
>
> "TIL article number 16405" would allow people to find the document by
> number...
>

so putting this "TIL article number 16405" is correct instead of Article 
number 16405:

>
>> diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
>> index 6bdbf48..92806c0 100644
>> --- a/arch/m68k/q40/README
>> +++ b/arch/m68k/q40/README
>> @@ -3,7 +3,7 @@ Linux for the Q40
>>
>>   You may try http://www.geocities.com/SiliconValley/Bay/2602/ for
>>   some up to date information. Booter and other tools will be also
>> -available from this place or ftp.uni-erlangen.de/linux/680x0/q40/
>> +available from this place or http://www.linux-m68k.org/mail.html
>>   and mirrors.
>>
>>   Hints to documentation usually refer to the linux source tree in
>
> No. We already discussed this change. Please refer back to my review of
> the first version of the patch. You got it right in the second version
> (that I also reviewed), but now you've gone back to the first version...
>
> Finn
>

pretty bad.. I don't know what happened there..


Justin P. Mattock
