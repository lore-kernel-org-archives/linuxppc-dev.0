Date: Thu, 8 Feb 2001 14:28:55 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: David Edelsohn <dje@watson.ibm.com>
Cc: paulus@linuxcare.com.au, Dan Malek <dan@mvista.com>,
	Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
	linuxppc-commit@hq.fsmlabs.com,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
Message-ID: <20010208142855.J24312@hq.fsmlabs.com>
References: <paulus@linuxcare.com.au> <200102081900.OAA25574@mal-ach.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200102081900.OAA25574@mal-ach.watson.ibm.com>; from David Edelsohn on Thu, Feb 08, 2001 at 02:00:07PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


} that the port is not using the PowerPC architecture as intended.  By not
} utilizing the hardware assists, the port is not performing at its optimal
} level.

I have data, and have written a paper with Victor and Paul, showing that we
get performance _increases_ by not using the PowerPC MMU architecture as
intended.  I think the PPC architecture intentions for the hash table and
TLB and very very poor and restrictive.  The 603 was a good step forward
but the 750, 7400 and follow-ons have been steps backwards from this good
start.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
