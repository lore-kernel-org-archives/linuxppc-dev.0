From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14840.57279.687704.440865@argo.linuxcare.com.au>
Date: Fri, 27 Oct 2000 12:51:59 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18pre17 again
In-Reply-To: <14839.53124.753011.489351@argo.linuxcare.com.au>
References: <14839.53124.753011.489351@argo.linuxcare.com.au>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just fixed a very silly mistake in _set_L2CR in my 2.2.18pre17
tree.  If you tried it on a G3 or G4 and it crashed on boot, please
try again.  The updated source is on ppc.linuxcare.com and
penguinppc.org as usual.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
