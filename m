From: "Jim Lewis" <jlewis@mvista.com>
To: "Ralph Blach" <rcblach@raleigh.ibm.com>,
	"Embedded Linux list" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Whate kind of kernel errors cause an Segmentation Fault
Date: Fri, 30 Mar 2001 08:38:18 -0600
Message-ID: <NDBBLNMCOLBBHLKBOLFEGEEHCOAA.jlewis@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3AC495E2.D7352CF4@raleigh.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Segmentation Fault" gets printed when a SIGSEGV is sent to a process.
Look in arch/ppc/kernel for SIGSEGV. Two exceptions I know will cause
it are Machine-check and Alignment.
-Jim Lewis

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of Ralph
> Blach
> Sent: Friday, March 30, 2001 8:19 AM
> To: Embedded Linux list
> Subject: Whate kind of kernel errors cause an Segmentation Fault
>
>
> What kind of kernel return codes will cause the C library
> to print out
> the message
>
> "Segmentation Fault"
>
> Thanks
>
> Chip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
