Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/5] Support 64K pages mapping of SPE local stores on 4K
	kernel
Date: Sat, 21 Apr 2007 22:33:34 +0200
References: <1172835163.743765.616483133775.qpush@grosgo>
In-Reply-To: <1172835163.743765.616483133775.qpush@grosgo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704212233.34521.arnd.bergmann@de.ibm.com>
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 02 March 2007, Benjamin Herrenschmidt wrote:
> This serie of patches supports userland mappings of SPE local stores
> using 64K hardware pages rather than 4K on a kernel using 4K pages to
> improve performances.

Ben, I have problems porting these patches to powerpc.git#for-2.6.22.
Could you port them yourself and submit them to Paul? What is the
status of the second patch, do you have a version suitable for upstream?

	Arnd <><
