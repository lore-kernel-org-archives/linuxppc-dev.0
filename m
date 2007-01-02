Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 94071DDF7B
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:51:19 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1685526ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Jan 2007 14:51:18 -0800 (PST)
Message-ID: <528646bc0701021451m4902ed5eu9e7346eb0d5563c8@mail.gmail.com>
Date: Tue, 2 Jan 2007 15:51:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sylvain Munaut" <tnt@246tnt.com>
Subject: Re: [PATCH 4/4] powerpc: Restore 'proper' link order in platform
In-Reply-To: <11677769992439-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
	<11677769982640-git-send-email-tnt@246tNt.com>
	<11677769981995-git-send-email-tnt@246tNt.com>
	<11677769992439-git-send-email-tnt@246tNt.com>
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
> The 52xx was put before CHRP to allow EFIKA to be recognized
> properly. Now the efika tree is fixed up in prom_init so
> no need for this ugly hack. So we restore the 'normal'
> order.
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>
