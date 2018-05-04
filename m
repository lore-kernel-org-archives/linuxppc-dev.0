Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cgy85GnbzF14s
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 15:47:12 +1000 (AEST)
Message-ID: <1525412819.2560.0.camel@russell.cc>
Subject: Re: [PATCH 01/13] powerpc/eeh: Add eeh_max_freezes to initial EEH
 log line
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 May 2018 15:46:59 +1000
In-Reply-To: <ac861431c98e0c259fec18a0d220994ad6b362ae.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <ac861431c98e0c259fec18a0d220994ad6b362ae.1525242772.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-02 at 16:34 +1000, Sam Bobroff wrote:
> The current failure message includes the number of failures that have
> occurred in the last hour (for a device) but it does not indicate
> how many failures will be tolerated before the device is permanently
> disabled.
> 
> Include the limit (eeh_max_freezes) to make this less surprising when
> it happens.
> 
> Also remove the embedded newline from the existing message to make it
> easier to grep for.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Good idea.

Reviewed-by: Russell Currey <ruscur@russell.cc>
