Subject: Re: Debugging Network Performance
To: <acurtis@onz.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <OFA5A51CBB.95D864D5-ON85256BCE.003C5665@raleigh.ibm.com>
From: "Mark Wisner" <markwiz@us.ibm.com>
Date: Tue, 4 Jun 2002 07:12:40 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen,
Netperf can give you a vary detailed report about network performance. If
you think your problem is related to network hardware problems, look at the
errors listed in "ifconfig". This should tell you if you are getting bad
packets or dropping packets.
If you think it is a kernel problem some benchmarks may help you narrow
down the problem. Networks are pretty fluid and sometimes hard to get
reproducible results. When I try to determine driver/kernel network
perfomance I try to use an isolated network where I have control over all
traffic or I use test hardware such as IXIA or Smartbits.

Mark K. Wisner
Advisory Software Engineer
IBM Microelectronics
3039 Cornwallis Rd
RTP, NC 27709
Tel. 919-254-7191
Fax 919-543-7575


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
