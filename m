Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: parallel I/O ports & opend darin pins on MPC8xx
Date: Tue, 8 Jul 2003 17:31:35 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJOEFEDEAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

on one of our boards we are using one of the I/O pins in open drain mode. This leads to some problems in combination with other
drivers that write to the ports data register. Since they can not detect the current output value of the open drain pin. They only
see the status of the I/O pin no matter who forces the value the CPM or another device connected to the open drain pin. After
writing back the value read from the I/O data register this value is forced by CPM which is normaly wrong.

Did anyone run into that problem in the past? What was your solution? Any thing else but NOT using open drain pins?

Thanks, Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
