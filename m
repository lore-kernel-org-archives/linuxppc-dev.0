Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-32.bluehost.com (outbound-mail-32.bluehost.com
	[70.96.188.152]) by ozlabs.org (Postfix) with SMTP id E0DD368A11
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 05:35:09 +1100 (EST)
Message-ID: <43C7F2C9.8040204@secretlab.ca>
Date: Fri, 13 Jan 2006 11:34:49 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 08/10] ML300 & ML403 need embed_config.o linked in
References: <11367955811900-git-send-email-grant.likely@secretlab.ca>
	<87psmwq9da.fsf@48ers.dk>
In-Reply-To: <87psmwq9da.fsf@48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: dhlii@dlasys.net, gnathita@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:

>>>>>>"grant" == grant likely <grant.likely@secretlab.ca> writes:
>>>>>>            
>>>>>>
>
> grant> +boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
> grant> +boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
>
>Notice that the ML300 line already is in mainline and pending for
>2.6.15.1.
>
>  
>
Good to know; we were just discussing if this was the case on #mklinux

Thanks

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
