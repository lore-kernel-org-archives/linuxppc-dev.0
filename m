From: markwiz@us.ibm.com
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <85256907.006BC49E.00@d54mta03.raleigh.ibm.com>
Date: Fri, 23 Jun 2000 15:37:05 -0400
Subject: Re: ASM-PPC Include File Rework Proposal: Processor / Board
	 Header Files
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I agree in part with both Dan and Grant.  May I suggest the processor.h
file be organized as follows:

Section 1: SPR Definitions
     1.A : Common SPR defines
     1:B: 6xx Specific defines
     1:C: 8xx Specific defines
     1.D: 403 Specific defines
     1.E: 405 Specific defines
             :
             :
Section 2: SPR Bit definitions
     2.A: Common Bit defines
     2.B: 6xx Specific Bit defines
     2.C: 8xx Specific Bit defines
     2.D 403 Specific Bit defines
     2.E: 405 Specific Bit defines
          :
          :
With this format multiple files are not needed and it should be easier to
read because it would eliminate many of the #ifdefs. It also would allow
new processor definitions to be added in the future.

Mark K. Wisner
Staff Software Engineer
IBM Microelectronics
3039 Cornwallis Rd
RTP, NC 27709
Tel. 919-254-7191
Fax 919-543-7575


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
