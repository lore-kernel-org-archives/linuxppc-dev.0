Return-Path: <azhar904@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 2EF08B7D2E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Jun 2010 21:41:03 +1000 (EST)
Received: by pwj6 with SMTP id 6so4606pwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 03 Jun 2010 04:41:02 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 3 Jun 2010 17:11:02 +0530
Message-ID: <AANLkTinkw6CbuR8vg6HXs0gE9qGXb6t7E9NezytNRKVM@mail.gmail.com>
Subject: Adding a section to linux kernel
From: Azhar Shaikh <azhar904@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636e0b72755824104881eae18
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636e0b72755824104881eae18
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am building a kernel module on linux-2.6.31 on a PowerPC architecture.

While buildng the module i am including a static library given by the
client.

I am getting the below warning while building the module with the library:

WARNING: /home/drivers/modules/module.o (.ghsinfo): unexpected
non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

The .ghsinfo section i havent used in my code. It is being used in the
Library given by the client.
Does anyone know how do i include a section (namely .ghsinfo) into the
kernel to get rid of the above warning?

Regards,
Azhar

--001636e0b72755824104881eae18
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi,</p>
<p>I am building a kernel module on linux-2.6.31 on a PowerPC architecture.=
</p>
<p>While buildng the module i am including a static library given by the cl=
ient.</p>
<p>I am getting the below warning while building the module with the librar=
y:</p>
<p>WARNING: /home/drivers/modules/module.o (.ghsinfo): unexpected non-alloc=
atable section.<br>Did you forget to use &quot;ax&quot;/&quot;aw&quot; in a=
 .S file?<br>Note that for example &lt;linux/init.h&gt; contains<br>section=
 definitions for use in .S files.</p>

<p>The .ghsinfo section i havent used in my code. It is being used in the L=
ibrary given by the client.</p>
<div>Does anyone know how do i include a section (namely .ghsinfo) into the=
 kernel to get rid of the above warning?</div>
<div>=A0</div>
<div>Regards,</div>
<div>Azhar</div>

--001636e0b72755824104881eae18--
