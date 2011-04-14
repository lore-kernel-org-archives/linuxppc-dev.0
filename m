Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ECD50B6FB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 22:09:59 +1000 (EST)
Message-ID: <4DA6E429.7010408@embedded-sol.com>
Date: Thu, 14 Apr 2011 15:10:17 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: emre kara <emrekara2002@yahoo.co.uk>
Subject: Re: fsl elbc driver causes corruption with bus monitor timeouts while
	simultaneously access on Nor / Nand mtd partitions
References: <204286.97927.qm@web25602.mail.ukl.yahoo.com>
In-Reply-To: <204286.97927.qm@web25602.mail.ukl.yahoo.com>
Content-Type: text/html; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	David Woodhouse <David.Woodhouse@intel.com>,
	linux-kernel@vger.kernel.org, bayraktarz@yahoo.com,
	Lan Chunhe-B25806 <b25806@freescale.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    Hi,<br>
    <br>
    Adding linux-mtd list to CC.<br>
    <br>
    On 04/14/2011 10:06 AM, emre kara wrote:
    <blockquote cite="mid:204286.97927.qm@web25602.mail.ukl.yahoo.com"
      type="cite">
      <pre wrap="">Hi Scott, Roy.
Scott's "mtd: eLBC NAND: increase bus timeout to maximum" patch is excluded from kernel with Roy's "P4080/eLBC: Make Freescale elbc interrupt common to elbc devices" patch. I don't know the reason for it but this causes bus monitor timeouts and corrupts nand flash while using mainline kernel. As I know there is an errata related to this topic, I think "increasing bus timeout to maximum" is a must.
You can easly generate this situation with below commands:


</pre>
    </blockquote>
    I think Scott's patch was picked up by Artem Bityutskijy into his
    tree, but never made it to mainline.<br>
    <br>
    Felix.<br>
    <i>
    </i>
  </body>
</html>
