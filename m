Return-Path: <kumar.gala@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <402824c4830f426df0afdb3515b6df61@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 4 Mar 2005 18:24:37 -0600
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Cc: ppcembed Mailing List <linuxppc-embedded@ozlabs.org>
Subject: RFC: SPR namespace issue
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A while ago Al Viro made some changes to the SPR defines to remove some 
name space conflicts.  I wanted to see if anyone had any issue with 
removing the short hand versions of the defines in the various reg*.h 
headers.  This means all SPR references will be SPRN_<FOO> going 
forward.

If you do speak now.

- kumar
