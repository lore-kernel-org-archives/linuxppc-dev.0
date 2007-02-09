Return-Path: <krafft@de.ibm.com>
Date: Fri, 9 Feb 2007 18:35:29 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: linuxppc-dev@ozlabs.org, krafft@de.ibm.com, cbe-oss-dev@ozlabs.org
Subject: [patch 0/1] pmi: initial version
Message-ID: <20070209183529.67d542d5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a driver for the=20
"Platform Management Interrupt" interface.
PMI is basically yet another way to communicate with the BMC.
It provides small latency and thus can be used=20
to request frequency changes from the BMC.
PMI allows bidirectional communication.=20
The cpufreq driver can be notified about a new limit for=20
frequency changes for instance.
PMI can be found on future IBM products.

--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
