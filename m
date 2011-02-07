Return-Path: <tmarri@apm.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
	by ozlabs.org (Postfix) with SMTP id 4D31FB7178
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 05:53:51 +1100 (EST)
Received: by vxb41 with SMTP id 41so1684326vxb.0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Feb 2011 10:53:48 -0800 (PST)
From: Tirumala Marri <tmarri@apm.com>
References: <1295477855-14775-1-git-send-email-tmarri@apm.com>
	<20110126192743.646af6d2@desktopvm.lvknet>
In-Reply-To: <20110126192743.646af6d2@desktopvm.lvknet>
MIME-Version: 1.0
Date: Mon, 7 Feb 2011 10:53:47 -0800
Message-ID: <b1ca0e7cedbf942783fedb44fea7ee52@mail.gmail.com>
Subject: RE: [PATCH V8 04/10] USB/ppc4xx: Add Synopsys DWC OTG HCD function
To: Alexander Gordeev <lasaine@lvk.cs.msu.su>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>, Mark Miesfeld <mmiesfeld@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	}
 	dev_set_drvdata(_dev, dwc_otg_device);
 	hcd->regs = otg_dev->base;
+	hcd->rsrc_start = otg_dev->phys_addr;
+	hcd->rsrc_len = otg_dev->base_len;
 	hcd->self.otg_port = 1;

[Marri] Sure
