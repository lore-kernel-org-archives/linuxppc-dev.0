From: Daniel Wu <Daniel.Wu@alcatel.com.au>
Subject: Re: Porting LinuxPPC
To: linuxppc-embedded@lists.linuxppc.org
Message-Id: <00May23.171838est.115222@border.alcanet.com.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20000519051051.236093C972@elph.research.canon.com.au>
 <39253A48.24B90117@snmc.com> <39253D0B.F9AF86EE@raleigh.ibm.com>
 <392562CE.A71A4F49@embeddededge.com>
Date: Tue, 23 May 2000 17:18:36 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Thanks to all who responsed to my last qeustion. The problem was that the immr
was not setup correctly. Also since it is a custom board (MPC860T based), I had
to rewrite code to fill in the bd_t structure. The board is now sending
characters to the console, which is good but I still have one of the original
problems: I can only step through the code using the BDM debugger, but when I
run the code, it generates a software emulation exception and stops.

After some investigation, it seems that I can run the code up to the point
where the instructure cache is enabled - actually only a few lines at the top
of the startup code. My question is: are there any restrictions on when the
cache can be enabled? Are there anything else I've missed.

Thanks,
Daniel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
