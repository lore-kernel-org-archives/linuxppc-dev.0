Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 6DB64680D4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 23:14:44 +1000 (EST)
Message-ID: <4305DB42.1020501@ru.mvista.com>
Date: Fri, 19 Aug 2005 17:14:42 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
References: <8E342283C2100540AAC5D1030970547774A3D9@rcexc.racoms.loc>
In-Reply-To: <8E342283C2100540AAC5D1030970547774A3D9@rcexc.racoms.loc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC][PATCH] [1/2] 8xx platform definitions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Schaefer-Hutter, Peter wrote:
> Hello!
> 
> The last hunk in this patch looks a bit strange to me:
> 
> 
>>--- /dev/null
>>+++ b/arch/ppc/syslib/mpc8xx_sys.c
>>
>>  [ ... ]
>>
>>+		.mask 		= 0x00000000,
>>+		.value 		= 0x00000000,
>>+	},
>>+};
>>@@ -101,6 +105,22 @@ extern unsigned char __res[];
>>
>>struct pt_regs;
>>
>>+enum ppc_sys_devices {
> 
> 
> Seems a bit inbetween is missing...
> 

It's OK, just the default match for the list.


-- 
Sincerely,
Vitaly
