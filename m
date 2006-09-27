Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17690.63978.373862.727933@cargo.ozlabs.ibm.com>
Date: Thu, 28 Sep 2006 08:23:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19-rc1] ehea firmware interface based on Anton
	Blanchard's new hvcall interface
In-Reply-To: <451AF29D.2030102@garzik.org>
References: <200609271847.34258.ossthema@de.ibm.com>
	<451AF29D.2030102@garzik.org>
Cc: Thomas Klein <tklein@de.ibm.com>, pmac@au1.ibm.com,
	Jan-Bernd Themann <themann@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff,

> > This eHEA patch reflects changes according to Anton's new hvcall interface
> > which has been commited in Paul's git tree:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> 
> When is this going upstream?  I don't want things to get too out-of-sync.

It's upstream already, and currently the ehea driver in Linus' tree
doesn't compile as a result.

Paul.
