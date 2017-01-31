Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCF6D6YX7zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 16:23:32 +1100 (AEDT)
Date: Tue, 31 Jan 2017 06:23:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio Valverde <vlvrdv@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, rsa@us.ibm.com, trivial@kernel.org
Subject: Re: [PATCH] Remove extra include in HVC console tty framework
Message-ID: <20170131052335.GA22262@kroah.com>
References: <1485817043-7195-1-git-send-email-vlvrdv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485817043-7195-1-git-send-email-vlvrdv@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 30, 2017 at 04:57:23PM -0600, Sergio Valverde wrote:
> From: Sergio Valverde <vlvrdv@gmail.com>
> 
> An extra "init.h" include is found in the HVC console code.
> 
> While the code works as it is right now, it is a defect nevertheless.
> As such, the extra line is deleted.

It's not a "defect" as it's not wrong.  It's just an annoyance.  This
whole sentence should probably be removed.

thanks,

greg k-h
