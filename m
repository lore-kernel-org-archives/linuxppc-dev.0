Return-Path: <carl.erwin@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id ACC20DE0D8
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 00:23:39 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1523663yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 07:23:37 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 25 May 2009 16:23:37 +0200
Message-ID: <5c90346a0905250723t2c9d30a0qd4fbebed38917cd7@mail.gmail.com>
Subject: 82xx multiple soc support/initialization
From: Carl-Erwin GRIFFITH <carl.erwin@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=00163616469125fb3d046abd5b7a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00163616469125fb3d046abd5b7a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi guys,


 I'm working on an derived muas3001 board (kernel version 2.6.30-rc5),

and so far I did not find an example of multiple SOCs initialization.

The board has 3 cpus (only one core activated).

1) Is there a special syntax to use in the device tree ?

2) Do the kernel provide an API to support multiple SOCs ?


Best regards,

Carl-Erwin Griffith

--00163616469125fb3d046abd5b7a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



<p style="margin: 0px; text-indent: 0px;">Hi guys,</p><p style="margin: 0px; text-indent: 0px;"><br></p>
<p style="margin: 0px; text-indent: 0px;"></p>

<p style="margin: 0px; text-indent: 0px;">I&#39;m working on an derived muas3001 board (kernel version 2.6.30-rc5),
</p>
<p style="margin: 0px; text-indent: 0px;">and so far I did not find an example of multiple SOCs initialization.</p>
<p style="margin: 0px; text-indent: 0px;">The board has 3 cpus (only one core activated).</p><br><p style="margin: 0px; text-indent: 0px;">
1) Is there a special syntax to use in the device tree ?</p>
<p style="margin: 0px; text-indent: 0px;">2) Do the kernel provide an API to support multiple SOCs ? </p>
<p style="margin: 0px; text-indent: 0px;"></p>
<p style="margin: 0px; text-indent: 0px;"><br></p><p style="margin: 0px; text-indent: 0px;">Best regards,</p>
<p style="margin: 0px; text-indent: 0px;">Carl-Erwin Griffith</p><p style="margin: 0px; text-indent: 0px;"><br></p>
<p style="margin: 0px; text-indent: 0px;"></p>

--00163616469125fb3d046abd5b7a--
