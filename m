From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15700.52122.899541.683630@argo.ozlabs.ibm.com>
Date: Sat, 10 Aug 2002 18:15:22 +1000 (EST)
To: akuster@dslextreme.com
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: First steps to OCP device model integration
In-Reply-To: <3D541AE9.40007@dslextreme.com>
References: <20020809042605.GC23642@zax>
	<3D541AE9.40007@dslextreme.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


akuster writes:

> I object seriously.
>
>   Some of what you have might be useful.:) OCP is not just for 4xx.  In
> fact the name may need to change.  I have been working on overhalling
> this interface and testing the ideas before having a review of the
> changes.  I am on the hook to Paul and others to get this out in the
> open to discuss and am not ready.  So if you could just relax and wait I
> would appriciate it.  I would rather see the 2.5 kernel boot on a few
> 4xx boards

Two points:

- Integrating the OCP stuff into the unified device model (driverfs
  etc.) in 2.5 is essential.

- I really want to have some open discussions about ideas, structures
  etc. for OCP support *before* you have everything fully worked out. :)

Regards,
Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
