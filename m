Message-ID: <388F4CCF.661A2D75@netx4.com>
Date: Wed, 26 Jan 2000 14:36:47 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: Brendan.Simon@ctam.com.au,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: main kernel tree
References: <388F3D65.3B420FED@ctam.com.au> <388F18F5.BDE5D395@netx4.com> <00012611055301.05597@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:

>
> What kernel source version from the "main" tree actually builds and works
> pretty well for most/all of the 8xx platforms?  I am particularly interested in
> the CLLF supporting kernel.

The last 2.3.xx kernel I used was 2.3.18.  Since I have customers
building real products, all I have been using is 2.2.13.

Recently, I have been trying to get 2.3.xx updated with 8xx
modifications (like the FEC for the CLLF), but I have been
spending time just making the current tree build properly.

If you want 8xx that works, use the 2.2.13 kernel, and update
the FEC driver from the source on ppc.kernel.org.  That is all
I have been using for months.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
