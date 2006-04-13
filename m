Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch] cell: correctly detect systemsim host
Date: Thu, 13 Apr 2006 13:44:26 +0200
References: <443E38FE.2050304@de.ibm.com>
In-Reply-To: <443E38FE.2050304@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604131344.26392.arnd.bergmann@de.ibm.com>
Cc: Christian Krafft <krafft@de.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 13 April 2006 13:41, Christian Krafft wrote:
> Systemsim uses a different compatible property in the device tree.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Thanks.

I'm wondering if we should have that upstream, since some
more patches are currently required to run on systemsim
anyway. For now, I'll keep it in my tree.

	Arnd <><
