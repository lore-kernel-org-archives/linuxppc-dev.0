Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 67A086838D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 01:16:12 +1000 (EST)
Message-ID: <43429CBA.6050906@ru.mvista.com>
Date: Tue, 04 Oct 2005 19:16:10 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: KokHow.Teh@marconi.com
References: <OF3208D35D.AA3CBB6C-ON48257090.0019F4B3@uk.marconicomms.com>
	<200510041711.34388.david.jander@protonic.nl>
In-Reply-To: <200510041711.34388.david.jander@protonic.nl>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> On Tuesday 04 October 2005 08:54, KokHow Teh wrote:
> 
>>Hi;
>>      I have debian linux running on my PQ2FADS-ZU with devfs and serial
>>driver compiled in. I have read Documentation/serial-console.txt and I have
>>tried both passing "console=" option as well as without passing that to the
>>kernel and both don't give me the expected results.
>>      When I pass "console=tts/0,115200n8" to the kernel, I don't get any
>>console output until the login prompt which I set to 115200 in
>>/etc/inittab. When I don't pass "console=" option to the kernel, I get
>>console output all the way until "Freeing unused kernel memory:" and the
>>console output is garbled and I don't see any login prompt. Here is the
>>/dev/* content:
> 
> 
> I don't know exactly what I am talking about right now, but the string "tts/0" 
> in the console-line sounds suspicious to me. AFAIK when using devfs still 
> device names on the kernel-commandline have to be old-style.
> Just a guess: try using "console=ttyS0,115200n8" and see if this helps.
> 
Yes, but PQ2FADS use cpm_uart and hence the commandline should be
console=ttyCPM0,115200

> Greetings,
> 


-- 
Sincerely,
Vitaly
