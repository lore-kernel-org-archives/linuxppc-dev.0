Message-ID: <3D3DD903.3070300@dslextreme.com>
Date: Tue, 23 Jul 2002 15:30:27 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: [RFC/Patch] ppc4xx_pm.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am in the process of fixing the init of the pm for 4xx in ppc4xx_pm.c
so that it can be used and I and others have discussed having the
drivers enable/disable their own power managment bits at init & exit times.

So what I would like to do is have each core header define a default set
of what is required to be powered on and then have each driver enable
them selves.  These changes would be done in two stages

1) fix ppc4xx_pm.c init and have the default pm bitmap set to all ocp
drivers on.

2) update ocp drivers to enable/disable their pm settings and remove
their enable bits from the default bitmap in the core headers.

armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
