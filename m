Message-Id: <200002021738.MAA19666@mal-ach.watson.ibm.com>
To: Stephane GEORGES <sg@dalim.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: is gcc optimized for g4 processors ?
In-Reply-To: Message from Stephane GEORGES <sg@dalim.de>
   of "Wed, 02 Feb 2000 18:01:02 +0100." <389862CD.5E291FB7@dalim.de>
Date: Wed, 02 Feb 2000 12:38:07 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Stephane GEORGES writes:

Stephane> I'm doing performance tests on my G4 - 400 AGP.
Stephane> I would like to know if gcc (egcs-2.91.66) can be optimized for G4 processor.

Stephane> Does -mcpu=7400 exists ?

	Currently there are no scheduling definitions for MPC7400
integrated into GCC.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
