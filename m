Return-Path: <bgat@billgatliff.com>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id C7A12B6EEA
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 07:07:25 +1100 (EST)
Received: by gxk23 with SMTP id 23so20270777gxk.2
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Jan 2010 12:07:24 -0800 (PST)
Message-ID: <4B44ED99.3020706@billgatliff.com>
Date: Wed, 06 Jan 2010 14:07:53 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/2] Create an of_i2c_gpiochip_add()
References: <1262749898-19197-1-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262749898-19197-1-git-send-email-bgat@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bill Gatliff wrote:
> This patch series creates an of_i2c_gpiochip_add() function, to allow
> i2c-based GPIO expanders to work with device tree gpio specifications.
>   

So nobody has any yays or nays on this?  I was expecting at least
_something_!  :)

Does the lack of response mean I'll be seeing these in an upcoming
kernel release?  I'd like to, because then I could more easily push
through related updates to a few i2c device drivers that I have in my
local repo.


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com
