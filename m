Message-ID: <3D106DC2.B50D7100@icn.siemens.de>
Date: Wed, 19 Jun 2002 13:40:50 +0200
From: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Neil Horman <nhorman@lvl7.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>,
	Frank Rowand <frank_rowand@mvista.com>
Subject: Re: Accessing the user stack inside system call service routine
References: <3D084D1F.95AFFCBB@icn.siemens.de>
		<3D087D95.5070206@lvl7.com>
		<3D08AA25.9AF41113@icn.siemens.de> <15625.4799.671581.186354@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> That is indeed very strange.  The first word should be non-zero at the
> very least.  Is it possible that your program has in fact trashed its
> stack?  Another thing to try would be to check the contents of
> current->user_stack_xxx immediately after you copy it to see whether
> it is all zero at that point.

Thank you all for the answer, it is now working fine.

I have basically used the LTT routine to analyze the EABI stack
frames, provided by Frank.

When I copy the relevant addresses (backchain pointer, saved link
register)
to separate static buffer and not to the task structure it is
working.


Steffen


--


--------------------------------------------------------------

Steffen Rumler
ICN ON PNE SB 4
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
