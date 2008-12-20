Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 0E37BDDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 18:18:28 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so456091yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 23:18:27 -0800 (PST)
Message-ID: <fa686aa40812192318m397aab91kcd1684fe80b52d67@mail.gmail.com>
Date: Sat, 20 Dec 2008 00:18:26 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
In-Reply-To: <633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <AclPDG6qSkF9cHawTOKR6zBfDIjvgg==>
	<633A55242A59C7488FAAF5A6850929984B814A@SRVEXC01.sts.saurer.vpn>
Cc: Tim Yamin <plasm@roo.me.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 25, 2008 at 7:45 AM, Lehmann, Hans (Ritter Elektronik)
<hans.lehmann@ritter-elektronik.de> wrote:
> Tim, Grant,
>
> just an info.
>
> Very often the Bestcomm-FEC crashed without any error logs if I initiate a transaction over FEC and save the file to disk (I rememeber I have read something like that). A restart of FEC don't work.
> But no I figured out, if I connect to the other ethernet port of our board (natsemi) the FEC will awake to life again, if I initiate a new transaction over natsemi. This seems a little oddly to me.

Hans, what ATA modes do you see this problem in?  UDMA?  MWDMA?  Or
does just having the patch applied but still using PIO mode expose the
problem?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
