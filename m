Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 83B08DDEE8
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:52:21 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1685685ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Jan 2007 14:52:21 -0800 (PST)
Message-ID: <528646bc0701021452q2a8359c2y73e3caa048ab0fe3@mail.gmail.com>
Date: Tue, 2 Jan 2007 15:52:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sylvain Munaut" <tnt@246tnt.com>
Subject: Re: [PATCH 2/4] powerpc: 52xx,
	Don't use device_initcall to probe of_platform_bus
In-Reply-To: <11677769982640-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
	<11677769982640-git-send-email-tnt@246tNt.com>
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/07, Sylvain Munaut <tnt@246tnt.com> wrote:
> Using device_initcall makes it happen for every platform that
> compiles this file in. This is really bad, for obvious reasons.
>
> Instead, we use the .init field of the machine description. If
> the platform needs the hook to do something specific it can provides
> its own function and call mpc52xx_declare_of_platform_devices from
> there. If not, the mpc52xx_declare_of_platform_devices function can
> directly be used as the init hook.
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
