Return-Path: <jjboor@aimsys.nl>
Received: from smtp04.wanadoo.nl (smtp04.wanadoo.nl [194.134.35.144])
	by ozlabs.org (Postfix) with ESMTP id 342B467A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 19:44:15 +1100 (EST)
In-Reply-To: <HMECJAKDCPLOGPDHNAHECEKFCAAA.jean.nicollerat@microdev.ch>
References: <HMECJAKDCPLOGPDHNAHECEKFCAAA.jean.nicollerat@microdev.ch>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0564629e9badf21667478887889a0a0a@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Thu, 17 Mar 2005 09:23:02 +0100
To: "Jean Nicollerat MD" <jean.nicollerat@microdev.ch>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RTC with TQM823L
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Can't you use a cpmtimer to fire every 10ms and wakeup a
high priority thread?

Jaap-Jan

On 17-mrt-05, at 8:47, Jean Nicollerat MD wrote:

> Hello,
> I need to have an interrup every 10ms in my application running in 
> linux.
> I have a PowerPC 823 on the board TQM823L LCD from denx.
> I use the ocan driver.
> I try to use the RTC modules but with the code :
>
> 	fd = open ("/dev/rtc", O_RDONLY);
>
> 	if (fd ==  -1) {
> 		perror("/dev/rtc");
> 	}
> 	/* Turn on update interrupts (one per second) */
>
> 	retval = ioctl(fd, RTC_UIE_ON, 0);
> 	if (retval == -1) {
> 		perror("ioctl");
> 		//exit(errno);
> 	}
>
> I get an error message :
>   ioctl : invalide argument # for then line :"retval = ioctl(fd, 
> RTC_UIE_ON,
> 0);"
>
> Can somebody help ? why it is not working or a better way to get 
> function
> called each 10ms
>
> Thanks
>
> Jean
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
