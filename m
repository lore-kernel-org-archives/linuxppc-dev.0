Message-ID: <3F5739D2.7080203@gdatech.co.in>
Date: Thu, 04 Sep 2003 18:40:42 +0530
From: "s.lavanya" <s.lavanya@gdatech.co.in>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: MPC 8245 JTAG related problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


With reference to the BSDL file MPC8345BSDL2.txt there are some
clerifications
needed.
(i) In the BSDL file the boundary length specified is BOUNDARY_LENGTH
of MPC8245: entity is 507 but while testing, it seems to be there are only
506 cells in the JTAG chain between the TDI and TDO lines.
(ii) In the BSDL file(Page 12) there is a function control = control cell
with resetb reset to "input". Kindly give the explaination.
(iii) Similary in the same page it is writen safe = value in control cell to
make input normally = 0 for bidir and control. Kindly give the explaination
(iv) dsval = diabling(input) value what do you mean by this?
Kindly send me mail as soon as possible to s.lavanya@gdatech.co.in

We want to program the flash memory through the 8 bit JTAG interface.
Update DR does not affect the expected pins. For example WE_L pin, I am
setting as 0. But it remains in 1. Always WE_L remains in high. Similar is
the case with the datapins. (We use MDH0 to MDH7) as our
SDRAM data lines. (I have doubts in the number shifts whether it is 506 or
507 including the exit DR shift) Will you please help me out by giving the
sample JTAG code which we can modify and use. Please give the details about
the direction control of bidir signals and resetb.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
