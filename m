Return-Path: <meador_inge@mentor.com>
Message-ID: <4D34E3E7.7050201@mentor.com>
Date: Mon, 17 Jan 2011 18:50:47 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2]: powerpc: MPIC binding and 'no-reset' implementation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: minge <meador_inge@mentor.com>, devicetree-discuss@lists.ozlabs.org,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set provides a binding for the MPIC and implements support 
for a new property, specified by that binding, called 'no-reset'.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
CC: Hollis Blanchard <hollis_blanchard@mentor.com>
