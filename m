Return-Path: <jiri@resnulli.us>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
 [209.85.212.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E74791A0001
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 19:11:24 +1100 (AEDT)
Received: by wiwh11 with SMTP id h11so20603106wiw.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2015 00:11:20 -0800 (PST)
Date: Tue, 3 Mar 2015 09:11:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] ibmveth: Add function to enable live MAC address
 changes
Message-ID: <20150303081114.GA2045@nanopsycho.orion>
References: <1425318972-19455-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425318972-19455-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: brking@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mon, Mar 02, 2015 at 06:56:12PM CET, tlfalcon@linux.vnet.ibm.com wrote:
>Add a function that will enable changing the MAC address
>of an ibmveth interface while it is still running.
>
>Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Reviewed-by: Jiri Pirko <jiri@resnulli.us>
