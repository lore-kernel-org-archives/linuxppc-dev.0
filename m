Message-ID: <3CE4FECD.5040404@elsoft.ch>
Date: Fri, 17 May 2002 14:59:57 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Several patches agains linuxppc_devel-2.4.19-pre8
References: <3CE2481B.5070108@elsoft.ch>
Content-Type: multipart/mixed;
 boundary="------------010701090101050502090200"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010701090101050502090200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello

Two new patches:

    - arch/ppc/kernel/ocp.c
       add default case in ocp_unregister().
       GCC 3.1 is not happy without it ;-)

    - drivers/net/ibm_ocp/ibm_ocp_debug.c
       ibm_ocp_debug.c seems not to be updated by the latest 4xx ethernet
       driver patches.


Dave

--------------010701090101050502090200
Content-Type: application/octet-stream;
 name="patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch.bz2"

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
OXIB1UY/4u5IpwoSE4BcP4A=
--------------010701090101050502090200--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
