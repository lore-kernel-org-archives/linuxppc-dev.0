Return-Path: <mgreer@mvista.com>
Date: Tue, 30 Aug 2005 16:38:51 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Message-ID: <20050830233851.GA29529@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Remove progress msgs from MMU_init()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This dates back to a discussion in May.  This patch addresses point 1)
in the email below by ripping out the progress msgs from MMU_init().
This would allow us to get rid of all the xxx_set_bat() routines in the
various platform files.

Does anyone object to this patch?

Mark

http://ozlabs.org/pipermail/linuxppc-dev/2005-May/019120.html
