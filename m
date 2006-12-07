Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 2503867BE1
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:46:24 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so523970ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Dec 2006 09:46:22 -0800 (PST)
Message-ID: <528646bc0612070946lc83afe2le7859324fae4a9fd@mail.gmail.com>
Date: Thu, 7 Dec 2006 10:46:11 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "timur@freescale.com" <timur@freescale.com>
Subject: Re: [PATCH] Remove QE header files from lite5200.c
In-Reply-To: <11655112521223-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11655112521223-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/7/06, timur@freescale.com <timur@freescale.com> wrote:
> From: Timur Tabi <timur@freescale.com>
>
> The MPC 5200 does not have a QUICCEngine (QE), so lite5200.c should not
> include the QE header files.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
