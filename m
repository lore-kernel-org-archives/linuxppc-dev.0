Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 127BEDDFC8
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 09:53:48 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1686069ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Jan 2007 14:53:47 -0800 (PST)
Message-ID: <528646bc0701021453q43853eccu74c91cb7c4a4e679@mail.gmail.com>
Date: Tue, 2 Jan 2007 15:53:47 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Sylvain Munaut" <tnt@246tnt.com>
Subject: Re: [PATCH 3/4] powerpc: Use common 52xx of_platform probe code for
	EFIKA
In-Reply-To: <11677769981995-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
	<11677769982640-git-send-email-tnt@246tNt.com>
	<11677769981995-git-send-email-tnt@246tNt.com>
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
> Now that the device tree has the good properties, we can
> remove all the efika_init code by a single call to common code.
>
> While we're modifying that file, a few whitespaces/alignement/typo
> fixes are made (nothing significant).
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
