Mime-Version: 1.0
Message-Id: <p05101400b8836c3106a5@[10.0.0.42]>
In-Reply-To: <20020203185831.MQZJ9396.tomts12-srv.bellnexxia.net@there>
References: <20020202144614.WRFZ11118.tomts10-srv.bellnexxia.net@there>
 <20020202201115.17827@smtp.wanadoo.fr>
 <20020203185831.MQZJ9396.tomts12-srv.bellnexxia.net@there>
Date: Sun, 3 Feb 2002 14:39:49 -0800
To: yellowdog-devel@lists.yellowdoglinux.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: some questions on new dual 1Gig G4's support?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:02 PM -0500 2/3/02, Kevin B. Hendricks wrote:

>According to the Apple developers note just released for this machine its
>model ID is simply "PowerMac3,5" which is unchanged from previous versions
>and already covered in the pmac_feature.c file.

Yep.  It is exactly the same motherboard as the previous set of
machines (733 / dual 800 / 867).  There might be firmware changes to
support the new cpus but the hardware is identical, and I believe
that Apple's intent with the model IDs is to identify motherboard
architectures, not cpus.

--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
