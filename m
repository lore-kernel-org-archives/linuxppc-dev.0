Return-Path: <glikely@secretlab.ca>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3275A2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 06:47:47 +1000 (EST)
Received: by mail-wg0-f54.google.com with SMTP id e12so89131wgh.21
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 13:47:44 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] of: Feed entire flattened device tree into the random pool
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20130729131150.591926c3@kryten>
References: <20130725125122.78accf44@kryten>
 <20130725031717.GB15673@concordia> <20130725143031.16af0a96@kryten>
 <20130728044942.A58793E0A24@localhost> <20130729131150.591926c3@kryten>
Date: Thu, 29 Aug 2013 21:47:48 +0100
Message-Id: <20130829204748.E8F6D3E1222@localhost>
Cc: devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 29 Jul 2013 13:11:50 +1000, Anton Blanchard <anton@samba.org> wrote:
> 
> Hi,
> 
> > be32_to_cpu(initial_boot_params->totalsize);
> 
> Ouch, thanks Grant.
> 
> Anton
> --
> 
> We feed the entire DMI table into the random pool to provide
> better random data during early boot, so do the same with the
> flattened device tree.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied, thanks

g.
