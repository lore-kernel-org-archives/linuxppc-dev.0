Return-Path: <celius202@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id BE5FFDDDB2
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 16:46:36 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so219891qwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 22:46:35 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 19 Mar 2009 14:46:34 +0900
Message-ID: <ffa0ad880903182246y4323e31bv6109fbf748858af0@mail.gmail.com>
Subject: suspend-to-mem on the mpc8349e-mitx-gp?
From: Soohyung Cho <celius202@gmail.com>
To: linuxppc-dev@ozlabs.org, scottwood@freescale.com
Content-Type: multipart/alternative; boundary=001517503ba6b39c640465725255
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001517503ba6b39c640465725255
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.

I need to enable suspend-to-mem(deep sleep) on my mpc8349e-mitx-gp box.
When I send "mem" message to /sys/power/state, the box seems to get stop.
I think the box get stop when it executes suspend-asm.S codes.

I know that the latest linux supports suspend-to-mem on the mpc8313erdb box
well.
Is it impossible to enable suspend-to-mem on the mpc8349e-mitx-gp?

--001517503ba6b39c640465725255
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.<br><br>I need to enable suspend-to-mem(deep sleep) on my mpc8349e-mitx-gp box.<br>When I send &quot;mem&quot; message to /sys/power/state, the box seems to get stop.<br>I think the box get stop when it executes suspend-asm.S codes.<br>
<br>I know that the latest linux supports suspend-to-mem on the  mpc8313erdb box well.<br>Is it impossible to enable suspend-to-mem on the mpc8349e-mitx-gp?<br><br>

--001517503ba6b39c640465725255--
