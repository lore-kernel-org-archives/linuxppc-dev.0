Return-Path: <wg@grandegger.com>
Message-ID: <4889F32F.3020606@grandegger.com>
Date: Fri, 25 Jul 2008 17:37:19 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] powerpc: 85xx: add proper OF bus ids for the TQM85xx
References: <48898470.80109@grandegger.com>	<fa686aa40807250620r1ab574basd07ecce6be2bc238@mail.gmail.com>
	<4889EE4C.9040705@grandegger.com> <4889F180.80203@freescale.com>
In-Reply-To: <4889F180.80203@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> Wolfgang Grandegger wrote:
> 
>> Ah, I see. For the TQM8548 adding the following compatible line:
>>
>>         soc8548@e0000000 {
>>         ...
>>         compatible = "fsl,mpc8548-immr", "simple-bus";
>>
> 
> 
> Hmmmm..... While you are there, I think you should drop
> the "8548" part of "soc8548" to get just "soc@e0000000".

Well, right. I'm going to check the tqm8548.dts file more carefully.

Wolfgang.
