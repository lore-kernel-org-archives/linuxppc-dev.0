From: clark@esteem.com
Message-Id: <1.5.4.32.20000901180437.006994e4@pop.esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 01 Sep 2000 11:04:37 -0700
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA Port Data line assignment
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

        I know this is more of a hardware question but the software has to
deal with it. When interfacing to a PCMCIA slot how should the data lines be
connected. We have books that disagree with each other.

        This is how I think it should be done. Which is how the FADS board
does it and its documentation says to do it.

MPC8xx ----- PCMCIA SLOT
D7              D0
D6              D1
D5              D2
D4              D3
D3              D4
D2              D5
D1              D6
D0              D7

D15             D8
D14             D9
D13             D10
D12             D11
D11             D12
D10             D13
D9              D14
D8              D15

        This is how the Motorola book says it should be done.

MPC8xx ----- PCMCIA SLOT
D0              D0
D1              D1
D2              D2
D3              D3
D4              D4
D5              D5
D6              D6
D7              D7

D8              D8
D9              D9
D10             D10
D11             D11
D12             D12
D13             D13
D14             D14
D15             D15

        This is how our other books says it should be done.

MPC8xx ----- PCMCIA SLOT
D8              D0
D9              D1
D10             D2
D11             D3
D12             D4
D13             D5
D14             D6
D15             D7

D0              D8
D1              D9
D2              D10
D3              D11
D4              D12
D5              D13
D6              D14
D7              D15



        any input would be appreciated.


        Thanks

        Conn Clark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
